module S3Helper

    require 'digest/hmac'

    def get_resume_data

        logger.info "getting resume data..."

        path = "updated_resume.pdf"
        full_url = File.join(@@base_url, path)

        options = { 
            headers: generate_header(path, 'GET')
        }

        logger.info "sending header #{options.inspect}"
        
        res = HTTParty.get(full_url, options)

        logger.info "request completed with status #{res.code.inspect}"

        res.body

    end

private

    @@base_url = "http://andys-website-assets.s3.amazonaws.com"
    @@bucket = "andys-website-assets"
    @@access_id = "AKIAI6R7I2B3XTKMB76A"
    @@access_secret = "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"
    @@sha1_digest = OpenSSL::Digest.new('sha1')

    def generate_header(path, method)
        auth = generate_auth(path, method)
        { 
            "Authorization" => auth[:authorization],
            "Date" => auth[:date]
        }
    end

    def generate_auth(path, method)

        formatted_path = File.join('', @@bucket, path)
        date_str = now
        string_to_sign = method.upcase + "\n\n\n"
        string_to_sign += date_str + "\n" + formatted_path

        signed_str = sign(string_to_sign)

        auth_str = "AWS " + @@access_id + ":" + signed_str

        {
          authorization: auth_str,
          date: date_str
        }
    end

    def now
        DateTime.now.strftime("%a, %e %b %Y %H:%M:%S %z")
        # ""

    end

    def sign(s)

        x = OpenSSL::HMAC.digest(@@sha1_digest, @@access_secret, s)
        return Base64.encode64(x)

    end


end
