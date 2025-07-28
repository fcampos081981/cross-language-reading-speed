import os
import time
import psutil

class DirectoryScanner:
    def __init__(self, directory, output_file):
        self.directory = directory
        self.output_file = output_file

    def scan_and_write(self):
        if not os.path.isdir(self.directory):
            print("O diretório informado não existe.")
            return

        with open(self.output_file, "w") as file:
            for root, dirs, files in os.walk(self.directory):
                for name in files:
                    full_path = os.path.join(root, name)
                    #print(full_path)  # Exibe o caminho no console
                    file.write(full_path + "\n")  # Grava o caminho no arquivo

        print(f"Os caminhos dos arquivos foram gravados em {self.output_file}")


if __name__ == "__main__":
    start_time = time.time()
    process = psutil.Process()

    directory = "/home"
    output_file = "/home/usuario/outfiles/output_python.txt"
    scanner = DirectoryScanner(directory, output_file)
    scanner.scan_and_write()
    end_time = time.time()
    execution_time = end_time - start_time
    print(f"Tempo de execução: {execution_time:.4f} segundos")
    file_path="/home/usuario/execution_times.txt"
    cpu_percent = process.cpu_percent(interval=1)
    cpu_time = process.cpu_times()
    memory_info = process.memory_info()
    memory_percent = process.memory_percent()
    char ="*"
    repeated = char * 70
    lines = []
    lines.append(f"\n")
    lines.append(repeated)
    lines.append(f"Python")
    formatted_time = time.strftime("%d/%m/%Y %H:%M:%S", time.localtime(start_time))
    lines.append(f"Start: {formatted_time}")
    formatted_time = time.strftime("%d/%m/%Y %H:%M:%S", time.localtime(end_time))
    lines.append(f"End: {formatted_time}")
    lines.append(f"Execution time: {execution_time:.4f}")
    lines.append(f"CPU usage: {cpu_percent}%")
    lines.append(f"CPU time in user mode: {cpu_time.user} seconds")
    lines.append(f"CPU time in kernel mode: {cpu_time.system} seconds")
    lines.append(f"Memory usage: {memory_info.rss / 1024 / 1024:.2f} MB (RSS)")
    lines.append(f"Percentage of memory used: {memory_percent:.2f}%")
    lines.append(repeated)
    lines.append("\n")

    with open(file_path, "a") as file:
        file.write("\n".join(lines))

    print(f"Add line in time file: {file_path}")