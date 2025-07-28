#include <iostream>
#include <filesystem>
#include <fstream>
#include <chrono>
#include <vector>
#include <iomanip>
#include <unistd.h>

namespace fs = std::filesystem;

class DirectoryScanner {
public:
    DirectoryScanner(const std::string &directory, const std::string &outputFile): directoryPath(directory),
        outputFilePath(outputFile) {
    }


    void scanAndWrite() {
        std::ofstream outputfile(outputFilePath);
        if (!outputfile.is_open()) {
            std::cerr << "Could not open output file " << outputFilePath << std::endl;
            return;
        }
        try {
            for (const auto &entry: fs::recursive_directory_iterator(directoryPath)) {
                if (entry.is_regular_file()) {
                    std::string filePath = entry.path().string();
                    //std::cout << filePath << std::endl;
                    outputfile << filePath << std::endl;
                }
            }
            //std::cout << outputFilePath << std::endl;
        } catch (const std::exception &e) {
            std::cerr << "Error: " << e.what() << std::endl;
        }
    }

private:
    std::string directoryPath;
    std::string outputFilePath;
};

int main() {
    auto start = std::chrono::high_resolution_clock::now();
    auto timeNowStart = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
    pid_t pid = getpid();
    std::string statPath = "/proc/" + std::to_string(pid) + "/stat";

    std::ifstream statFile(statPath);

    if (!statFile.is_open()) {
        std::cerr << "Erro ao abrir " << statPath << std::endl;
        return 1;
    }

    std::string line;
    std::getline(statFile, line);
    statFile.close();

    std::vector<std::string> lines;
    std::string fileName = "/home/usuario/execution_times.txt";


    std::string directory = "/home";
    std::string outputFile = "/home/usuario/outfiles/output_cpp.txt";
    DirectoryScanner directoryScanner(directory, outputFile);
    directoryScanner.scanAndWrite();

    auto end = std::chrono::high_resolution_clock::now();
    auto timeNowEnd = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());
    std::chrono::duration<double> duration = end - start;

    std::cout << "Tempo de execução: " << duration.count() << " segundos" << std::endl;

    std::tm *localTimeStart = std::localtime(&timeNowStart);
    std::ostringstream timeStreamStart;
    timeStreamStart << std::setw(2) << std::setfill('0') << localTimeStart->tm_hour << ":"
            << std::setw(2) << std::setfill('0') << localTimeStart->tm_min << ":"
            << std::setw(2) << std::setfill('0') << localTimeStart->tm_sec;


    std::tm *localTimeEnd = std::localtime(&timeNowEnd);
    std::ostringstream timeStreamEnd;
    timeStreamEnd << std::setw(2) << std::setfill('0') << localTimeEnd->tm_hour << ":"
            << std::setw(2) << std::setfill('0') << localTimeEnd->tm_min << ":"
            << std::setw(2) << std::setfill('0') << localTimeEnd->tm_sec;


    std::istringstream iss(line);
    std::string token;
    int field = 1;
    long utime = 0, stime = 0, rss = 0;
    while (iss >> token) {
        if (field == 14) utime = std::stol(token);
        if (field == 15) stime = std::stol(token);
        if (field == 24) rss = std::stol(token);
        field++;
    }

    long pageSize = sysconf(_SC_PAGESIZE);
    long memoryUsage = rss * pageSize;

    std::ostringstream logStream;


    std::string repeated = std::string(70, '*');
    lines.push_back("\n");
    lines.emplace_back(repeated);
    lines.emplace_back("C++");
    lines.emplace_back("Start: " + timeStreamStart.str());
    lines.emplace_back("End: " + timeStreamEnd.str());
    lines.emplace_back("Execution time: " + std::to_string(duration.count()));
    lines.emplace_back("Memory usage (in bytes): " + std::to_string(memoryUsage) );
    lines.emplace_back("CPU time in user mode: " + std::to_string(utime) );
    lines.emplace_back("Kernel Mode CPU Time: " + std::to_string(stime) );
    lines.emplace_back("File with listed files: " + outputFile );

    lines.push_back(repeated);

    std::ofstream outFile(fileName, std::ios::app);
    if (!outFile) {
        std::cerr << "Error try write in file!" << std::endl;
        return 1;
    }

    for (const auto &line: lines) {
        outFile << line << std::endl;
    }

    outFile.close();

    std::cout << "Add line in time file: " + fileName << std::endl;
    return 0;
}
