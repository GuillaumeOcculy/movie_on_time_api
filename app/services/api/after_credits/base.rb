module Api::AfterCredits
  class Base
    include HTTParty

    base_uri Settings.after_credits.base_url

    # Api::AfterCredits::Base.movie_details('Fast')
    def self.movie_details(movie_title)
      params = {
        'limit': 250,
        'order': 'movieName',
        '_method': 'GET',
        'where': {
          '$or': [{
            'movieName': {
              '$regex': "(?i)#{movie_title}"
            }
          }, {
            'tags': movie_title
          }, {
            'username': movie_title
          }]
        }
      }

      response = post('/parse/classes/ArchiveMovies',
        body: params.to_json,
        headers: {
          "X-Parse-Application-Id" => Settings.after_credits.application_id,
          "X-Parse-Client-Key" => Settings.after_credits.api_key,
          "Content-Type" => "application/json; charset=utf-8",
        },
      )

      response['results']
    end
  end
end
