module PostsHelper
  def posts_order(options={})
    if options[:order]
      options[:order] = "#{options[:order]}"
    end
    params.slice(:order).merge(options)
  end

end
