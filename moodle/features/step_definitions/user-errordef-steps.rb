Given(/^the user error: "([^"]*)" means "([^"]*)"$/) do |errorid, errorstr|
  @errors = {} if not defined? @errors
  @errors[errorid] = errorstr
end
