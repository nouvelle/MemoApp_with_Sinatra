# frozen_string_literal: true

# Memoクラス
class Memo
  def initialize
    @data_list = CSV.read('./memo_db.csv').sort
  end

  def get
    @data_list
  end

  def get_by_id(id)
    result = []
    @data_list.each do |data|
      result = data if data[0] == id
    end
    result
  end

  def create(title, contents)
    id = @data_list.map { |array| array[0] }.max
    CSV.open('./memo_db.csv', 'a') do |csv|
      csv << [id.to_i + 1, title, contents]
    end
  end

  def update(id, title, contents)
    @data_list.delete_if { |array| array[0] == id }
    CSV.open('./memo_db.csv', 'w') do |csv|
      @data_list.each do |array|
        csv << array
      end
      csv << [id, title, contents]
    end
  end

  def delete(id)
    @data_list.delete_if { |array| array[0] == id }
    CSV.open('./memo_db.csv', 'w') do |csv|
      @data_list.each do |array|
        csv << array
      end
    end
  end
end
