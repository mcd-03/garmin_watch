import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;

class fountain_penView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Get variables for use in view updates
        var userProfile = UserProfile.getProfile();
        var birthYear = "" + userProfile.birthYear;
        var weight = "" + userProfile.weight / 1000 + " kg";
        var gender = "" + userProfile.gender;
        var vo2 = "" + userProfile.vo2maxRunning;

        // var hr = SensorHistory.getHeartRateHistory(null).next();


        var userActivity = ActivityMonitor.getInfo();
        // var hrIterator = ActivityMonitor.getHeartRateHistory(null, false);
        // var hr = "" + hrIterator.heartRate;
        var steps = "" + userActivity.steps;
        var calories = "" + userActivity.calories;

        // var vo2 = userProfile.vo2maxRunning;

        // Update the center view
        var view = View.findDrawableById("center") as Text;
        view.setColor(getApp().getProperty("ForegroundColor") as Number);
        view.setText(timeString);
        
        // Update north view
        var myStats = System.getSystemStats();
        View.findDrawableById("north").setText(myStats.battery.format("%d") + "%");

        // Update north-east view
        View.findDrawableById("northeast").setText("" + userProfile.birthYear);

        // Update east view
        View.findDrawableById("east").setText(weight);

        // Update south-east view
        View.findDrawableById("southeast").setText(vo2);

        // Update south view
        View.findDrawableById("south").setText(steps);

        // Update south-west view
        View.findDrawableById("southwest").setText(calories);

        // Update west view
        View.findDrawableById("west").setText("w");
        
        // Update north-west view
        View.findDrawableById("northwest").setText("nw");


        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
