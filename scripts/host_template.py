import socket
import sys
from json.tool import main
from pathlib import Path

from pythonping import ping
from rich.console import Console
from rich.progress import track
from rich.table import Table

hosts = []

class Host:
    def __init__(self, host, ports_to_scan=[21, 22, 80, 88, 445, 3389]):
        self.host = host
        self.ping = 'Unknown'
        self.host_folder = Path(self.host)
        self.ports_to_scan = ports_to_scan
        self.open_ports = []
        self.os = 'Unknown'
        self.role = 'Unknown'
        
        self._generate_folder()
        self._write_notes()
        self._ping()
        self._port_scan()
        self._write_ports()
        self._guess_os_role()

    def __str__(self):
        return f'{self.host} ({self.os})'

    def _ping(self):
        try:
            ping_response = ping(self.host, size=40, count=2, verbose=False)
        
            if ping_response.success():
                self.ping = '[green]Response[/green]'
            else:
                self.ping = '[red]No Response[/red]'
        except PermissionError:
            self.ping = 'Permission Error'
        except:
            self.ping = 'Unknown'

    def _port_scan(self):
        for port in self.ports_to_scan:
            try:
                s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                s.settimeout(1)
                s.connect((self.host, port))
                s.close()

                self.open_ports.append(port)
            except socket.error:
                pass

    def _write_ports(self):
        ports_file = Path(self.host_folder / 'scans/minimal_port_scan.log')
        ports_file.write_text('\n'.join([str(p) for p in self.open_ports]))

    def _write_notes(self):
        notes_file = Path(self.host_folder / 'notes.md')
        notes_file.write_text(f'# {self.host}\n\n')

    def _guess_os_role(self):
        # OS
        if any(p in self.open_ports for p in [88, 445, 3389]):
            self.os = '[blue]Windows[/blue]'
        if 22 in self.open_ports:
            self.os = '[yellow]Unix/Linux[/yellow]'
        
        # Role
        if any(p in self.open_ports for p in [21, 80]):
            self.role = 'Server'
        if 88 in self.open_ports:
            self.role = '[bold red]Domain Controller[/bold red]'

    def _generate_folder(self):
   
        folders = ['scans', 'screenshots', 'loot', 'code']
        files = ['notes.md', 'scans/minimal_port_scan.log']

        self.host_folder.mkdir(parents=True, exist_ok=True)
        for folder in folders:
            Path(self.host_folder / folder).mkdir(parents=True, exist_ok=True)
        
        for file in files:
            Path(self.host_folder / file).touch(exist_ok=True)

    def row(self):
        return (self.host, self.ping, ','.join([str(p) for p in self.open_ports]), f'{self.os}/{self.role}')


def print_hosts():
    table = Table(title='Hosts',)

    table.add_column('Host', style='cyan', no_wrap=True)
    table.add_column('Ping')
    table.add_column('Important Ports')
    table.add_column('OS/Role (Guess)')

    for host in hosts:
        table.add_row(*host.row())

    console = Console()
    console.print(table)


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print(f'Usage: host_template.py <host_list>/<host>')
        sys.exit(1)

    host_input = Path(sys.argv[1])

    if not host_input.is_file():
        hosts.append(Host(sys.argv[1]))
    else:
        for host in track(host_input.read_text().splitlines()):
            hosts.append(Host(host))

    print_hosts()
