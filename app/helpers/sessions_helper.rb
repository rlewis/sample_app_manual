module SessionsHelper
    # Added remember control for HW 9
    def sign_in(user, remember)
        if remember.nil? 
            puts "**sign_in where remember = nil**"
            cookies.signed[:remember_token] = [user.id, user.salt]
        else
            puts "!!sign_in where remember = true!!"
            cookies.permanent.signed[:remember_token] = [user.id, user.salt]
        end
        
        user.touch(:last_login_at) # Added for HW 9
        #user.update_login # Added for HW 9
        self.current_user = user 
    end
    
    def current_user=(user)
        @current_user = user
    end
    
    def current_user
        @current_user ||= user_from_remember_token
    end
    
    def signed_in?
        !current_user.nil?
    end
    
    def sign_out
        cookies.delete(:remember_token)
        self.current_user = nil
    end
    
    private
    
        def user_from_remember_token
            User.authenticate_with_salt(*remember_token) # * allows the use of a 2D array argument to a function expecting two args
        end
        
        def remember_token
            cookies.signed[:remember_token] || [nil, nil]
        end
end
