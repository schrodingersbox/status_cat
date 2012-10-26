module StatusCat::StatusHelper

  def status_header
    content_tag( :tr ) do
      concat content_tag( :th, t( :name, :scope => :status_cat ) )
      concat content_tag( :th, t( :value, :scope => :status_cat ) )
      concat content_tag( :th, t( :status, :scope => :status_cat ) )
    end
  end

  def status_row( checker )
    content_tag( :tr ) do
      concat content_tag( :td, checker.name, :style => status_style( checker ) )
      concat content_tag( :td, checker.value )
      concat content_tag( :td, checker.status )
    end
  end

  def status_style( checker )
    "background-color: #{checker.status.nil? ? :green : :red}"
  end

  def status_table( checkers )
    content_tag( :table, :border => 1 ) do
      concat status_header
      checkers.each { |checker| concat status_row( checker ) }
    end
  end

  def status_title
    content_tag( :h1, t( :h1, :scope => :status_cat ) )
  end

end