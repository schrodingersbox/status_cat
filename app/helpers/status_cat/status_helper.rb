module StatusCat::StatusHelper

  # Constructs an HTML table header

  def status_header
    content_tag( :tr ) do
      concat content_tag( :th, t( :name, :scope => :status_cat ) )
      concat content_tag( :th, t( :value, :scope => :status_cat ) )
      concat content_tag( :th, t( :status, :scope => :status_cat ) )
    end
  end

  # Constructs and HTML table row

  def status_row( checker )
    content_tag( :tr ) do
      concat content_tag( :td, checker.name, :style => status_style( checker ) )
      concat content_tag( :td, checker.value )
      concat content_tag( :td, checker.status )
    end
  end

  # Returns an HTML style for the status table cell

  def status_style( checker )
    "background-color: #{checker.status.nil? ? :green : :red}"
  end

  # Returns an HTML table

  def status_table( checkers )
    content_tag( :table, :border => 1 ) do
      concat status_header
      checkers.each { |checker| concat status_row( checker ) }
    end
  end

  # Returns an HTML title

  def status_title
    content_tag( :h1, t( :h1, :scope => :status_cat ) )
  end

  # Constructs a text status report

  def status_report( checkers )
    format, format_length = status_report_format( checkers )
    header = status_report_header( format )
    length = [ format_length, header.length ].max
    separator = ( '-' * length ) + "\n"

    result = separator + header + separator
    checkers.each { |checker| result << checker.to_s( format ) }
    result << separator

    return result
  end

  # Generate a format string to justify all values

  def status_report_format( checkers )
    name_max = checkers.map { |c| c.name.to_s.length }.max
    value_max = checkers.map { |c| c.value.to_s.length }.max
    status_max = checkers.map { |c| c.status.to_s.length }.max

    format = "%#{name_max}s | %#{value_max}s | %#{status_max}s\n"
    length = name_max + 3 +  value_max + 3 + status_max

    return format, length
  end

  # Generate a header string

  def status_report_header( format = StatusCat::Checkers::Base::FORMAT )
    name = I18n.t( :name, :scope => :status_cat )
    value = I18n.t( :value, :scope => :status_cat )
    status = I18n.t( :status, :scope => :status_cat )
    return sprintf( format, name, value, status )
  end

end