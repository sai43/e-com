module CorsHelper
  def cors_set_access_control_headers
    #raise env['HTTP_ORIGIN'].to_s
    if is_valid_cors_request?
      headers['Access-Control-Allow-Origin'] = env['HTTP_ORIGIN'].to_s
    end
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, X-CSRF-Token, X-User-Email, X-User-Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    puts env['HTTP_ORIGIN']
    if request.method == 'OPTIONS'
      cors_set_access_control_headers
      headers['Access-Control-Allow-Headers'] += ',X-Requested-With, X-Prototype-Version, Token, X-CSRF-Token, X-User-Email, X-User-Token'
      render :text => '', :content_type => 'text/plain'
    end
  end

  def is_valid_cors_request?
    byebug
    # Only returns true if the top-level domain is the same
    domain = 'http://localhost:3000'
    env['HTTP_ORIGIN'].to_s.gsub(/:\d+$/,'').ends_with?(domain)
  end

end