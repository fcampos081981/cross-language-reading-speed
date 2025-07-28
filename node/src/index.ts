import * as fs from 'fs';
import * as path from 'path';
import * as os from 'os';

class DirectoryScanner {
    private static outputFilePath: string = '/home/usuario/outfiles/output_node.txt';
    private static executionTimesFile: string = '/home/usuario/execution_times.txt';

    public static main(): void {
        const startTime: Date = new Date();
        const repeated: string = '*'.repeat(70);
        const directoryPath: string = '/home';
        const filePaths: string[] = [];


        this.readFilesRecursively(directoryPath, filePaths);


        this.writeFiles(filePaths);

        const endTime: Date = new Date();


        const duration: number = (endTime.getTime() - startTime.getTime()) / 1000;
        const hours: number = Math.floor(duration / 3600);
        const minutes: number = Math.floor((duration % 3600) / 60);
        const seconds: number = Math.floor(duration % 60);
        const formattedDuration: string = `${hours.toString().padStart(2, '0')}:${minutes
            .toString()
            .padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;

        const totalMemory: number = os.totalmem();
        const freeMemory: number = os.freemem();
        const usedMemory: number = totalMemory - freeMemory;
        const processCpuTime: number = process.cpuUsage().user / 1e6; // Convert to milliseconds


        const writer = fs.createWriteStream(this.executionTimesFile, { flags: 'a' });
        writer.write('\n');
        writer.write(`${repeated}\n`);
        writer.write('Node.js with TypeScript\n');
        writer.write(`Start: ${startTime.toTimeString().split(' ')[0]}\n`);
        writer.write(`End: ${endTime.toTimeString().split(' ')[0]}\n`);
        writer.write(`Execution time: ${formattedDuration}\n`);
        writer.write(`Memory usage (in bytes): ${usedMemory}\n`);
        writer.write(`CPU time in user mode (ms): ${processCpuTime}\n`);
        writer.write(`File with listed files: ${this.outputFilePath}\n`);
        writer.write(`${repeated}\n`);
        writer.end();

        console.log(`Add line in time file: ${this.executionTimesFile}`);
    }

    private static writeFiles(filePaths: string[]): void {
        try {
            const writer = fs.createWriteStream(this.outputFilePath);
            filePaths.forEach((filePath) => {
                writer.write(`${filePath}\n`);
            });
            writer.end();
        } catch (error) {
            const errorMessage = error instanceof Error ? error.message : String(error);
            console.error(`Error when trying : ${errorMessage}`);
        }
    }

    private static readFilesRecursively(directory: string, filePaths: string[]): void {
        try {
            const files = fs.readdirSync(directory);
            files.forEach((file) => {
                const filePath = path.join(directory, file);
                if (fs.statSync(filePath).isDirectory()) {
                    this.readFilesRecursively(filePath, filePaths);
                } else {
                    filePaths.push(filePath);
                }
            });
        } catch (error) {
            const errorMessage = error instanceof Error ? error.message : String(error);
            console.error(`Error when trying : ${errorMessage}`);
        }
    }
}


DirectoryScanner.main();