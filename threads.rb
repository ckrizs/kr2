mutex = Mutex.new
condition = ConditionVariable.new
counter = 1
max_count = 10

thread1 = Thread.new do
  loop do
    mutex.synchronize do
      condition.wait(mutex) until counter.odd? || counter > max_count
      break if counter > max_count
      puts "Thread 1: #{counter}"
      counter += 1
      condition.signal
    end
  end
end

thread2 = Thread.new do
  loop do
    mutex.synchronize do
      condition.wait(mutex) until counter.even? || counter > max_count
      break if counter > max_count
      puts "Thread 2: #{counter}"
      counter += 1
      condition.signal
    end
  end
end

condition.signal
thread1.join
thread2.join