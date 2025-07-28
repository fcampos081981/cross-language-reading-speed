<?php

#PHP 8.x
class DirectoryScanner
{
    private static string $outputFilePath = '/home/usuario/outfiles/output_php.txt';

    public static function main(): void
    {
        $startTime = microtime(true);
        $repeated = str_repeat('*', 70);
        $directoryPath = '/home';
        $filePaths = [];


        self::readFilesRecursively($directoryPath, $filePaths);


        self::writeFiles($filePaths);

        $endTime = microtime(true);
        $executionTimesFile = '/home/usuario/execution_times.txt';


        $duration = $endTime - $startTime;
        $hours = floor($duration / 3600);
        $minutes = floor(($duration % 3600) / 60);
        $seconds = $duration % 60;
        $formattedDuration = sprintf('%02d:%02d:%02d', $hours, $minutes, $seconds);


        $totalMemory = memory_get_usage(true);
        $freeMemory = memory_get_usage(false);
        $usedMemory = $totalMemory - $freeMemory;


        $writer = fopen($executionTimesFile, 'a');
        if ($writer) {
            fwrite($writer, PHP_EOL . $repeated . PHP_EOL);
            fwrite($writer, "PHP" . PHP_EOL);
            fwrite($writer, sprintf("Start: %s", date('H:i:s', (int)$startTime)) . PHP_EOL);
            fwrite($writer, sprintf("End: %s", date('H:i:s', (int)$endTime)) . PHP_EOL);
            fwrite($writer, sprintf("Execution time: %s", $formattedDuration) . PHP_EOL);
            fwrite($writer, sprintf("Memory usage (in bytes): %s", $usedMemory) . PHP_EOL);
            fwrite($writer, sprintf("File with listed files: %s", self::$outputFilePath) . PHP_EOL);
            fwrite($writer, $repeated . PHP_EOL);
            fclose($writer);
        }

        echo "Add line in time file: $executionTimesFile" . PHP_EOL;
    }

    private static function writeFiles(array $filePaths): void
    {
        $writer = fopen(self::$outputFilePath, 'w');
        if ($writer) {
            foreach ($filePaths as $path) {
                fwrite($writer, $path . PHP_EOL);
            }
            fclose($writer);
        } else {
            echo "Error when trying to write to file: " . self::$outputFilePath . PHP_EOL;
        }
    }

    private static function readFilesRecursively(string $directory, array &$filePaths): void
    {
        if (is_dir($directory)) {
            $files = scandir($directory);
            foreach ($files as $file) {
                if ($file === '.' || $file === '..') {
                    continue;
                }
                $filePath = $directory . DIRECTORY_SEPARATOR . $file;
                if (is_dir($filePath)) {
                    self::readFilesRecursively($filePath, $filePaths);
                } else {
                    $filePaths[] = $filePath;
                }
            }
        }
    }
}


DirectoryScanner::main();