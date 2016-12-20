class Job


  def initialize(raw_job)
    @uid = raw_job['id']
    @title = raw_job['title']
    @description = raw_job['description']
    @url = raw_job['url']
    @location = raw_job['location']
    @posted_date = raw_job['posted_date']
    @remote = raw_job['remote']
    @company_name = raw_job['company']['name']
    @raw_technologies = raw_job['technologies']
  end

  def technologies
    @raw_technologies.map do |tech|
      tech['name']
    end
  end
end
