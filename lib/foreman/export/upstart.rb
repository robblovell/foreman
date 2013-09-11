require "erb"
require "foreman/export"

class Foreman::Export::Upstart < Foreman::Export::Base

  def export
    super

    (Dir["#{location}/#{app}-*.conf"] << "#{location}/#{app}.conf").each do |file|
      clean file
    end

    write_template "upstart/master.conf.erb", "#{app}.conf", binding

    engine.each_process do |name, process|
      next if engine.formation[name] < 1
      write_template "upstart/process_master.conf.erb", "#{app}-#{name}.conf", binding

      1.upto(engine.formation[name]+base) do |num|
        port = engine.port_for(process, num)
        # TODO: pass flag with the process restart delay to the erb
        write_template "upstart/process.conf.erb", "#{app}-#{name}-#{num+base}.conf", binding
      end
    end
  end
end
