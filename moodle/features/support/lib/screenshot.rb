class Screenshot
  attr_accessor :screenshotn
  attr_reader :screenshotn

  def initialize
    @screenshotn = -1
  end

  def capture
    @screenshotn += 1
    @screenshotstr = "#{ENV["reportpath"]}/screenshot#{@screenshotn}.png"
    @screenshotstr
  end
end

After do |scenario|
  if scenario.failed? and @page != nil and @screenshoter != nil
    src = @screenshoter.capture
    @page.browser.screenshot.save(src)
    embed(src, 'image/png')
  end
end
