def ppp(*args)
  puts "\n\n\n\n\n\n\n\n"
  args.each { |arg| ap arg }
  res = yield.tap { |res| ap res } if block_given?
  puts "\n\n\n\n\n\n\n\n"
  res
end
