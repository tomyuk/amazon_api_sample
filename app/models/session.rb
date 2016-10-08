class Session < ActiveRecord::Base
  
  def self.cleanup
    if Session.table_exists?
      interval = 60.minutes
      sql = "DELETE FROM sessions WHERE updated_at < '#{(Time.now - interval).utc.to_s(:db)}'"
      ActiveRecord::Base.connection.raw_connection.exec(sql)
    end
  end

end
