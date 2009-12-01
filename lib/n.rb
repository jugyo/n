require 'rubygems'
require 'cgi'
require 'pp'

$n_priority ||= 'normal'
$n_expire ||= 3000

module Kernel
  def n(*args, &block)
    args.push(block) if block

    messages =
      if args.empty?
        [nil.pretty_inspect]
      else
        args.map { |i| i.pretty_inspect }
      end

    messages.each do |i|
      system 'notify-send',
             "--urgency=#{$n_priority}",
             "--expire-time=#{$n_expire}",
             "--",
             $0,
             CGI.escapeHTML(i)
    end

    if args.empty?
      nil
    elsif args.size == 1
      args.first
    else
      args
    end
  end
end
