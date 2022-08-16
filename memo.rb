# frozen_string_literal: true

# Memoクラス
class Memo
  def initialize
    host = ENV['DATABASE_HOST']
    user = ENV['DATABASE_USER']
    pw = ENV['DATABASE_PASSWORD']
    name = ENV['DATABASE_NAME']
    port = ENV['DATABASE_PORT']
    uri = "postgres://#{user}:#{pw}@#{host}:#{port}/#{name}"
    @conn = PG::Connection.new(uri)
  end

  def all
    data_list = []
    sql = 'SELECT * FROM memos ORDER BY id'
    @conn.exec(sql) do |result|
      result.each do |row|
        tmp = []
        tmp.push(row['id'], row['title'], row['contents'])
        data_list.push(tmp)
      end
    end
    data_list
  end

  def get_by_id(id)
    output = []
    sql = 'SELECT * FROM memos WHERE id = $1'
    @conn.exec_params(sql, [id]) do |result|
      result.each do |row|
        output = [row['id'], row['title'], row['contents']]
      end
    end
    output
  end

  def create(title, contents)
    sql = 'INSERT INTO memos (title, contents) VALUES ($1, $2)'
    @conn.exec_params(sql, [title, contents])
  end

  def update(id, title, contents)
    sql = 'UPDATE memos SET title = $2, contents = $3 WHERE id = $1'
    @conn.exec_params(sql, [id, title, contents])
  end

  def delete(id)
    sql = 'DELETE FROM memos WHERE id = $1'
    @conn.exec_params(sql, [id])
  end
end
