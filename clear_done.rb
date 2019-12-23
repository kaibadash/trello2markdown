# frozen_string_literal: true
require 'trello'
require 'dotenv'
require 'pry'

class ClearDone
  def initialize
    Dotenv.load
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
      config.member_token = ENV['TRELLO_MEMBER_TOKEN']
    end
  end

  def execute(argv)
    boards = Trello::Board.all
    target_board = argv[0] if argv.present?
    target_lists = argv[1..] if argv.length > 1
    boards.each do |board|
      next if board.closed?
      next unless target_board == board.name
      board.lists.each do |list|
        next if list.closed?
        next if target_lists.present? && !target_lists.include?(list.name)
        list.cards.each do |card|
          next if card.closed?
          puts "Close #{card.name}"
          card.close!
        end
      end
    end
  end
end

ClearDone.new.execute(ARGV)
