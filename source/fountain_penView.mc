import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.Weather;

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

        // Get variables for use in view updates
        var today = Time.Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var hour = today.hour;
        if (hour > 12) {
            hour = hour - 12;
        }
        var userProfile = UserProfile.getProfile();
        var birthYear = "" + userProfile.birthYear;
        var weight = "" + userProfile.weight / 1000 + " kg";
        var gender = "" + userProfile.gender;
        var vo2 = "VO2 " + userProfile.vo2maxRunning;
        var hr = "BPM " + SensorHistory.getHeartRateHistory(null).next().data;

        var temp = "" + Weather.getCurrentConditions().temperature;

        var userActivity = ActivityMonitor.getInfo();
        var steps = "STEPS " + userActivity.steps;
        var calories = "KCALS " + userActivity.calories;

        // Update hours
        View.findDrawableById("hourLabel").setText("" + hour.format("%02d"));

        // Update minutes
        View.findDrawableById("minLabel").setText("" + today.min.format("%02d"));

        // Update vo2
        View.findDrawableById("vo2Label").setText(vo2);

        // Update west view
        View.findDrawableById("heartRateLabel").setText(hr);

        // Update south view
        View.findDrawableById("calorieLabel").setText(calories);

        // Update south-west view
        View.findDrawableById("stepLabel").setText(steps);

        // Update dateLabel
        View.findDrawableById("dateLabel").setText("" + today.day_of_week + ", " + today.month + " " + today.day + " " + today.year);

        // // Update north view
        // var myStats = System.getSystemStats();
        // View.findDrawableById("north").setText(myStats.battery.format("%d") + "%");

        // // Update north-west view
        // View.findDrawableById("northwest").setText(temp);


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
