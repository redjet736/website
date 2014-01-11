module S3Helper

    def get_resume_data

        path = "updated_resume.pdf"
        full_url = File.join(base_url, path)

        options = { 
            headers: generate_header(path, 'GET')
        }
        
        res = HTTParty.get(full_url, options)

        res.body

    end

private

    base_url = "http://andys-website-assets.s3.amazonaws.com"
    bucket = "andys-website-assets"
    access_id = "AKIAI6R7I2B3XTKMB76A"
    access_secret = "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"

    def generate_header(path, method)
        auth = generate_auth(path, method)
        { 
            "Authorization" => auth[:authorization],
            "Date" => auth[:date]
        }
    end

    def generate_auth(path, method)

        formatted_path = File.join('', bucket, path)
        date_str = now
        string_to_sign = method.upcase + "\n\n\n"
        string_to_sign += date_str + "\n" + formatted_path

        signed_str = sign(string_to_sign)

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

        

    end


end
