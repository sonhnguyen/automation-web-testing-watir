# Web automated testing with Watir

#Installation:

1. Install ruby

	* For Windows: use RubyInstaller at: http://rubyinstaller.org/

2. Install Gem (Ruby Package Manager)

	* Install Development Kit at http://rubyinstaller.org/downloads/

	* Go to the devkit directory and type ruby dk.rb init to generate config.yml.

	* After reviewing the config.yml, you can finally type ruby dk.rb install.

	* It is done if you can use gem in cmd.

3. Type in cmd:

	* gem update --system --no-rdoc --no-ri

	* gem install watir --no-rdoc --no-ri

	* gem install require_all

	* gem install spreadsheet

# Software-Under-Test Setup

1. Download and Setup XAMPP and Test Database

	* Download XAMPP at https://www.apachefriends.org/index.html

	* Run downloaded execution file. Follow the installation

	* Launch XAMPP, make sure Apache, ProFTPD, and MySQL are all running

	* Open the browser and visit http://localhost/phpmyadmin/

	* Click Databases tab on the top panel and create a new Database

	* We name the database 'cs423_testdb'. On 'Collation' dropdown list, we choose 'utf8_unicode_ci'

	* Click SQL tab on the top panel and type this: grant all on cs423_testdb.* to tester@localhost identified by 'tester';

2. Download and Configure Moodle

	* Download Moodle source repo at https://download.moodle.org/

	* Extract the source folder to <XAMPP folder path>/htdocs/ .

	* In the web browser, follow this link: https://localhost/moodle/ to get to Moodle Installation

	* Choose 'English'. Click 'Next'.

	* Verify that Data directory is '<XAMPP folder path>/moodledata' and <XAMPP folder path> is writable on your system. Click 'Next'

	* Choose 'MySQL' option and click 'Next'.

	* This is Database configuration step. On 'Database name' field we type 'cs423_testdb'. On both 'Database user' and 'Database password' fields we type 'tester'. Leave the rests and click 'Next'

	* Please verify all settings are correct in the next screen. Click 'Next'

	* Wait and wait ... There should be a list of completed items consecutively appear on the browser screen. Keep sliding down until everything is completed. There is a Continue button at the bottom of the screen. click it

	* On the next screen, on 'Username' we type 'tester', 'Password' we type 'Testertester1*'. On 'First name' 'Last name' we type 'Tester'. On 'Email address' we type 'tester@cs423.com'. Then click 'Update profile'

	* On the next screen, 'Full site name' and 'Short site name' we type 'CS423Test'. Click 'Save changes'

	* Profit

	* Your username will be 'tester' and password will be 'Testertester1*'

# Functions:

	* Test click button

	* Assert results

	* Ajax call

	* Get value from web controls

	* Crawl data from html
