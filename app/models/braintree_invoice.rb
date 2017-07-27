require 'render_anywhere'

class BraintreeInvoice
  include RenderAnywhere

  def initialize(transaction)
    @transaction = transaction
  end

  def filename
    'invoice.pdf'
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file("#{Rails.root}/public/invoice.pdf")
  end

  private def as_html
    render template: 'subscriptions/invoice', layout: 'invoice_pdf', locals: { transaction: @transaction, customer: @transaction.customer_details, card: @transaction.credit_card_details }
  end
end
