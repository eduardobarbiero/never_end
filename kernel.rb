require 'sys/proctable'

class KillShit
  include Sys

  def self.list_process
    new().list_process
  end

  def self.kill_process pid
    new(pid).kill_process
  end

  def initialize pid = nil
    @process = pid
  end

  def list_process
    process = []
    begin
      ProcTable.ps{ |p|
        process_temp = Process.new
        process_temp.pid = p.pid.to_s
        process_temp.desc = p.comm
        process << process_temp
      }
    rescue
      list_process
      p 'error'
    end
    return process
  end

  def kill_process
    begin
      ProcTable.ps{ |p|
        if p.comm[@process]
          Process.kill('QUIT', p.pid)
        end
      }
    rescue
      list_process
      p 'error'
    end
  end

  class Process
    attr_accessor :pid
    attr_accessor :desc
  end
end
