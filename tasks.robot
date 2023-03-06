*** Settings ***
Documentation       Opens the Screenrant web page and stores some content.

Library             Collections
Library             RPA.Browser.Selenium
Library             RPA.FileSystem
Library             RPA.RobotLogListener


*** Variables ***
${TITLE}           the-bear
${NUMBER_OF_MOVIES}     1
${TITLE_DIRECTORY}      ${CURDIR}${/}output${/}${TITLE}

*** Tasks ***
Store Web Page Content
    Open Available Browser    https://screenrant.com/best-tv-shows-2022/
    Hide distracting UI elements
    Screenshot    id:${TITLE}    ${TITLE_DIRECTORY}${/}screenshot.png
    [Teardown]    Close Browser

*** Keywords ***
Hide element
    [Arguments]    ${locator}
    Mute Run On Failure    Execute Javascript
    Run Keyword And Ignore Error
    ...    Execute Javascript
    ...    document.querySelector('${locator}').style.display = 'none'

Hide distracting UI elements
    @{locators}=    Create List
    ...    header
    ...    \#layers > div
    ...    nav
    ...    div[data-testid="primaryColumn"] > div > div
    ...    div[data-testid="sidebarColumn"]
    ...    div[data-testid="inlinePrompt"]
    ...    div[data-testid="sheetDialog"]
    FOR    ${locator}    IN    @{locators}
        Hide element    ${locator}
    END