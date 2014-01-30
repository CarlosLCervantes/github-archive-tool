VALID_EVENT_TYPES = ["CommitCommentEvent",
							"CreateEvent",
							"DeleteEvent",
							"DownloadEvent",
							"FollowEvent",
							"ForkEvent",
							"ForkApplyEvent",
							"GistEvent",
							"GollumEvent",
							"IssueCommentEvent",
							"IssuesEvent",
							"MemberEvent",
							"PublicEvent",
							"PullRequestEvent",
							"PullRequestReviewCommentEvent",
							"PushEvent",
							"ReleaseEvent",
							"StatusEvent",
							"TeamAddEvent",
							"WatchEvent"]

def is_valid_event event
	VALID_EVENT_TYPES.any? {|e| e.upcase == event.upcase}
end