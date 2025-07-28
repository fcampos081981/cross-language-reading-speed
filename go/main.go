package main

import (
	"fmt"
	"github.com/shirou/gopsutil/v3/process"
	"log"
	"os"
	"path/filepath"
	"strings"
	"time"
)

func main() {
	start := time.Now()
	repeated := strings.Repeat("*", 70)

	var lines []string
	p, err := process.NewProcess(int32(os.Getpid()))
	if err != nil {
		log.Fatalf("Error getting the process: %v", err)
	}
	directory := "/home"
	outputFile := "/home/usuario/outfiles/output_go.txt"

	file, err := os.Create(outputFile)
	if err != nil {
		fmt.Println("Error creating the file:", err)
		return
	}
	defer file.Close()

	err = filepath.Walk(directory, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		if !info.IsDir() {
			_, err := file.WriteString(path + "\n")
			if err != nil {
				return err
			}
		}
		return nil
	})

	if err != nil {
		fmt.Println("Error scanning the directory:", err)
	} else {
		fmt.Println("File paths have been written to", outputFile)
		end := time.Now()
		startTime := start.Format("15:04:05")
		endTime := end.Format("15:04:05")
		duration := end.Sub(start)
		hours := int(duration.Hours())
		minutes := int(duration.Minutes()) % 60
		seconds := int(duration.Seconds()) % 60

		// Obter uso de CPU e memória
		cpuPercent, err := p.CPUPercent()
		if err != nil {
			log.Fatalf("Error getting CPU usage: %v", err)
		}
		memInfo, err := p.MemoryInfo()
		if err != nil {
			log.Fatalf("Error getting memory usage: %v", err)
		}

		lines = append(lines, "\n")
		lines = append(lines, repeated)
		lines = append(lines, "GO")
		lines = append(lines, "Start: "+startTime)
		lines = append(lines, "End: "+endTime)
		lines = append(lines, fmt.Sprintf("Execution time: %02d:%02d:%02d", hours, minutes, seconds))
		lines = append(lines, fmt.Sprintf("CPU usage: %.2f%%", cpuPercent))
		lines = append(lines, fmt.Sprintf("Memory RSS: %d bytes", memInfo.RSS))
		lines = append(lines, fmt.Sprintf("Memory VMS: %d bytes", memInfo.VMS))
		lines = append(lines, "File with listed files: "+outputFile)
		lines = append(lines, repeated)

		fileName := "/home/usuario/execution_times.txt"
		execFile, err := os.OpenFile(fileName, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
		if err != nil {
			fmt.Println("Error opening the file:", err)
			return
		}
		defer execFile.Close()

		_, err = execFile.WriteString("\n")
		for _, line := range lines {
			_, err = execFile.WriteString(line + "\n")
			if err != nil {
				fmt.Println("Error writing to the file:", err)
				return
			}
		}
		fmt.Println("Lines added to the execution times file:", fileName)
	}
}
