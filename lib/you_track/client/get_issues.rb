class YouTrack::Client::GetIssues < YouTrack::Client::Request
  def real(project, filters={})
    service.request(
      :path   => "/issue/byproject/#{project}",
      :parser => YouTrack::Parser::IssuesParser,
      :query  => filters,
    )
  end

  def mock(project, filters={})
    issues = service.data[:issues].values

    # delete first n elements from the array
    if filters["after"]
      issues.delete_if.with_index { |x,i| i < (filters["after"].to_i - 1) }
    end

    service.response(
      :body => issues
    )
  end
end
