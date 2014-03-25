Riemann::Tail.configure do |c|
  c.format :host, :blue
  c.format :metric, [:to_s, :cyan]

  c.format :tags, :light_black do |t|
    t.join(", ")
  end

  c.format :time, :light_black do |t|
    t.localtime.strftime("%T")
  end

  c.format :state, [:downcase, :bold] do |s|
    case s
    when /fail|err/i then s.red
    when /warn/i then s.yellow
    else s.green
    end
  end

  c.line_format = "%{time}#{">".light_black} %{state} %{host} %{service} %{tags} %{metric}\n        #{">".light_black} %{description}"
end
