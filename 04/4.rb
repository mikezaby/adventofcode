(0..Float::INFINITY).find {|i|  OpenSSL::Digest.new('md5', "iwrupvqb#{i}").to_s.start_with?('00000') }
