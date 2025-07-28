require 'time'

class DirectoryScanner
  OUTPUT_FILE_PATH = '/home/usuario/outfiles/output_ruby.txt'
  EXECUTION_TIMES_FILE = '/home/usuario/execution_times.txt'

  def self.main
    start_time = Time.now
    repeated = '*' * 70
    directory_path = '/home'
    file_paths = []


    read_files_recursively(directory_path, file_paths)


    write_files(file_paths)

    end_time = Time.now


    duration = end_time - start_time
    hours = (duration / 3600).to_i
    minutes = ((duration % 3600) / 60).to_i
    seconds = (duration % 60).to_i
    formatted_duration = format('%02d:%02d:%02d', hours, minutes, seconds)


    total_memory = `free -b | grep Mem | awk '{print $2}'`.to_i
    free_memory = `free -b | grep Mem | awk '{print $4}'`.to_i
    used_memory = total_memory - free_memory
    process_cpu_time = `ps -p #{Process.pid} -o cputime=`.strip


    File.open(EXECUTION_TIMES_FILE, 'a') do |writer|
      writer.puts
      writer.puts repeated
      writer.puts 'Ruby'
      writer.puts "Start: #{start_time.strftime('%H:%M:%S')}"
      writer.puts "End: #{end_time.strftime('%H:%M:%S')}"
      writer.puts "Execution time: #{formatted_duration}"
      writer.puts "Memory usage (in bytes): #{used_memory}"
      writer.puts "CPU time in user mode: #{process_cpu_time}"
      writer.puts "File with listed files: #{OUTPUT_FILE_PATH}"
      writer.puts repeated
    end

    puts "Add line in time file: #{EXECUTION_TIMES_FILE}"
  end

  def self.write_files(file_paths)
    File.open(OUTPUT_FILE_PATH, 'w') do |writer|
      file_paths.each do |path|
        writer.puts path
      end
    end
  rescue StandardError => e
    puts "Error when trying to write: #{e.message}"
  end

  def self.read_files_recursively(directory, file_paths)
    Dir.foreach(directory) do |file|
      next if file == '.' || file == '..'

      file_path = File.join(directory, file)
      if File.directory?(file_path)
        read_files_recursively(file_path, file_paths)
      else
        file_paths << file_path
      end
    end
  rescue StandardError => e
    puts "Error when reading directory: #{e.message}"
  end
end


DirectoryScanner.main