import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.lang.management.ManagementFactory;
import com.sun.management.OperatingSystemMXBean;


public class DirectoryScanner {

    public static String outputFilePath = "/home/usuario/outfiles/output_java.txt";

    public static void main(String[] args)   {
        LocalTime startTime = LocalTime.now();
        OperatingSystemMXBean osBean = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        String repeated = "*".repeat(70);
        String directoryPath = "/home";
        List<String> filePaths = new ArrayList<>();
        readFilesRecursively(new File(directoryPath), filePaths);
        writeFiles(filePaths);
        LocalTime endTime = LocalTime.now();

        String filePathExecute="/home/usuario/execution_times.txt";

        Duration duration = Duration.between(startTime, endTime);
        long hours = duration.toHours();
        long minutes = duration.toMinutes() % 60;
        long seconds = duration.getSeconds() % 60;
        String formattedDuration = String.format("%02d:%02d:%02d", hours, minutes, seconds);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePathExecute, true))) {
            double processCpuLoad = osBean.getProcessCpuLoad() * 100;
            long processCpuTime = osBean.getProcessCpuTime();
            long totalMemorySize = osBean.getTotalPhysicalMemorySize();
            long freeMemorySize = osBean.getFreePhysicalMemorySize();
            long usedMemorySize = totalMemorySize - freeMemorySize;
            writer.newLine();
            writer.write(repeated);
            writer.newLine();
            writer.write("Java");
            writer.newLine();
            writer.write(String.format("Start: %s", startTime.format(formatter)));
            writer.newLine();
            writer.write(String.format("End: %s", endTime.format(formatter)));
            writer.newLine();
            writer.write(String.format("Execution time: %s", formattedDuration));
            writer.newLine();
            writer.write(String.format("Memory usage (in bytes): %s",usedMemorySize ));
            writer.newLine();
            writer.write(String.format("CPU time in user mode: %s",processCpuTime));
            writer.newLine();
            writer.write(String.format("Kernel Mode CPU Time: %s",freeMemorySize));
            writer.newLine();
            writer.write(String.format("File with listed files: %s",outputFilePath));
            writer.newLine();
            writer.write(repeated);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }


        System.out.println("Add line in time file: " + filePathExecute);

    }

    private static void writeFiles(List<String> filePaths) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputFilePath))) {

            for (String path : filePaths) {
                writer.write(path);
                writer.newLine();
            }

        } catch (IOException e) {
            System.err.println("Error when try write: " + e.getMessage());
        }

    }

    private static void readFilesRecursively(File directory, List<String> filePaths) {
        if (directory.isDirectory()) {
            File[] files = directory.listFiles();
            if (files != null) {
                for (File file : files) {
                    if (file.isDirectory()) {
                        readFilesRecursively(file, filePaths);
                    } else {
                        filePaths.add(file.getAbsolutePath());
                    }
                }
            }
        }
    }
}
