class NotificationsController < ApplicationController
#    skip_before_filter :verify_authenticity_token, only: :create

  def create
      report = PagSeguro::Transaction.

      while report.next_page?
        report.next_page!
        puts "=> Page #{report.page}"

        abort "=> Errors: #{report.errors.join("\n")}" unless report.valid?

        puts "=> Report was created at: #{report.created_at}"
        puts

        report.transactions.each do |transaction|
          puts "=> Abandoned transaction"
          puts "   created at: #{transaction.created_at}"
          puts "   code: #{transaction.code}"
          puts "   type_id: #{transaction.type_id}"
          puts "   gross amount: #{transaction.gross_amount}"
          puts
        end
      end
  end
end
