use std::fs::{self, File, OpenOptions};
use std::io::{self, BufWriter, Write};
use std::path::Path;
use std::time::{Duration, Instant};
use sysinfo::{System, SystemExt, ProcessExt, Pid};
use chrono::{Local, Duration as ChronoDuration};

fn main() -> io::Result<()> {
    let start_time = Instant::now();
    let repeated = "*".repeat(70);
    let directory_path = "/home";
    let output_file_path = "/home/usuario/outfiles/output_rust.txt";
    let execution_times_file = "/home/usuario/execution_times.txt";

    // Collect file paths
    let mut file_paths = Vec::new();
    read_files_recursively(Path::new(directory_path), &mut file_paths)?;

    // Write file paths to output file
    write_files(&file_paths, output_file_path)?;

    // System information
    let mut system = System::new_all();
    system.refresh_all();

    let total_memory = system.total_memory() * 1024;
    let free_memory = system.free_memory() * 1024;
    let used_memory = total_memory - free_memory;

    let pid = Pid::from(std::process::id() as usize);
    if let Some(process) = system.process(pid) {
        let cpu_usage = process.cpu_usage();
        let process_cpu_time = process.run_time();

        let end_time = Instant::now();
        let duration = end_time.duration_since(start_time);
        let formatted_duration = format_duration(duration);


        let mut writer = BufWriter::new(OpenOptions::new()
            .append(true)
            .create(true)
            .write(true)
            .open(execution_times_file)?);

        writeln!(writer, "\n{}", repeated)?;
        writeln!(writer, "Rust")?;
        writeln!(writer, "Start: {}", format_time(start_time))?;
        writeln!(writer, "End: {}", format_time(end_time))?;
        writeln!(writer, "Execution time: {}", formatted_duration)?;
        writeln!(writer, "Memory usage (in bytes): {}", used_memory)?;
        writeln!(writer, "CPU usage: {:.2}%", cpu_usage)?;
        writeln!(writer, "CPU time in user mode: {} seconds", process_cpu_time)?;
        writeln!(writer, "File with listed files: {}", output_file_path)?;
        writeln!(writer, "{}", repeated)?;

        println!("Add line in time file: {}", execution_times_file);
    } else {
        eprintln!("Failed to retrieve process information.");
    }

    Ok(())
}

fn read_files_recursively(dir: &Path, file_paths: &mut Vec<String>) -> io::Result<()> {
    if dir.is_dir() {
        for entry in fs::read_dir(dir)? {
            let entry = entry?;
            let path = entry.path();
            if path.is_dir() {
                read_files_recursively(&path, file_paths)?;
            } else {
                file_paths.push(path.to_string_lossy().to_string());
            }
        }
    }
    Ok(())
}

fn write_files(file_paths: &[String], output_file_path: &str) -> io::Result<()> {
    let file = File::create(output_file_path)?;
    let mut writer = BufWriter::new(file);

    for path in file_paths {
        writeln!(writer, "{}", path)?;
    }

    Ok(())
}

fn format_duration(duration: Duration) -> String {
    let hours = duration.as_secs() / 3600;
    let minutes = (duration.as_secs() % 3600) / 60;
    let seconds = duration.as_secs() % 60;
    format!("{:02}:{:02}:{:02}", hours, minutes, seconds)
}

fn format_time(instant: Instant) -> String {
    let elapsed = instant.elapsed();
    let now = Local::now() - ChronoDuration::from_std(elapsed).unwrap();
    now.format("%H:%M:%S").to_string()
}