module PostsHelper
  def posts_order(options={})
    if options[:order]
      options[:order] = "#{options[:order]}"
    end
    params.slice(:order, :category).merge(options)
  end

  def posts_filter(options={})
    if options[:category]
      params.slice(:order, :category).merge(options)
    end
  end
end
