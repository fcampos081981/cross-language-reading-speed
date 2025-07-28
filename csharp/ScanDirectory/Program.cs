
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;

internal class Program
{
    public static string OutputFilePath = "/home/usuario/outfiles/output_csharp.txt";
    public static void Main(string[] args)
    {
        var startTime = DateTime.Now;
        Process currentProcess = Process.GetCurrentProcess();
        string repeated = new string('*', 70);
        string directoryPath = "/home";
        List<string> filePaths = new List<string>();
      
        ReadFilesRecursively(new DirectoryInfo(directoryPath), filePaths);

       
        WriteFiles(filePaths);

        
        var endTime = DateTime.Now;

        string filePathExecute = "/home/usuario/execution_times.txt";

        
        TimeSpan duration = endTime - startTime;
        string formattedDuration = string.Format("{0:00}:{1:00}:{2:00}", 
            (int)duration.TotalHours, duration.Minutes, duration.Seconds);

      
        try
        {

            long usedMemorySize = Process.GetCurrentProcess().WorkingSet64;
            TimeSpan totalProcessorTime = currentProcess.TotalProcessorTime;  
            TimeSpan userProcessorTime = currentProcess.UserProcessorTime;    
            TimeSpan privilegedProcessorTime = currentProcess.PrivilegedProcessorTime;  
            using (StreamWriter writer = new StreamWriter(filePathExecute, true))
            {
                writer.WriteLine();
                writer.WriteLine(repeated);
                writer.WriteLine("C#");
                writer.WriteLine($"Start: {startTime:HH:mm:ss}");
                writer.WriteLine($"End: {endTime:HH:mm:ss}");
                writer.WriteLine($"Execution time: {formattedDuration}");
                writer.WriteLine($"Memory usage (in bytes): {usedMemorySize}");
                writer.WriteLine($"Total CPU time: {totalProcessorTime}");
                writer.WriteLine($"CPU time in user mode: {userProcessorTime}");
                writer.WriteLine($"CPU time in kernel mode: {privilegedProcessorTime}");
                writer.WriteLine($"File with listed files: {OutputFilePath}");
                writer.WriteLine(repeated);
            }
        }
        catch (IOException e)
        {
            throw new Exception("Error writing execution times file", e);
        }

        Console.WriteLine("Add line in time file: " + filePathExecute);;
    }
    
    private static void WriteFiles(List<string> filePaths)
    {
        try
        {
            using (StreamWriter writer = new StreamWriter(OutputFilePath))
            {
                foreach (string path in filePaths)
                {
                    writer.WriteLine(path);
                }
            }
        }
        catch (IOException e)
        {
            Console.Error.WriteLine("Error when trying to write: " + e.Message);
        }
    }
    
    private static void ReadFilesRecursively(DirectoryInfo directory, List<string> filePaths)
    {
        if (directory.Exists)
        {
            try
            {
                foreach (var file in directory.GetFiles())
                {
                    filePaths.Add(file.FullName);
                }

                foreach (var subDirectory in directory.GetDirectories())
                {
                    ReadFilesRecursively(subDirectory, filePaths);
                }
            }
            catch (UnauthorizedAccessException e)
            {
                Console.Error.WriteLine("Access denied to directory: " + directory.FullName);
            }
        }
    }
}