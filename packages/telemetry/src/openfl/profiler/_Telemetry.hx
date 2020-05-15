package openfl.profiler;

#if ((cpp || neko) && hxtelemetry && !macro)
import hxhxTelemetry.HxTelemetry;
#end
import openfl._internal.Lib;

#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
@:allow(openfl.display.Stage)
@:noCompletion
class _Telemetry
{
	public static var connected(get, never):Bool;
	public static var spanMarker = 0.0;

	#if ((cpp || neko) && hxtelemetry && !macro)
	public static var hxTelemetry:HxTelemetry;
	#end

	public static function registerCommandHandler(commandName:String, handler:Dynamic):Bool
	{
		return false;
	}

	public static function sendMetric(metric:String, value:Dynamic):Void {}

	public static function sendSpanMetric(metric:String, startSpanMarker:Float, value:Dynamic = null):Void {}

	public static function unregisterCommandHandler(commandName:String):Bool
	{
		return false;
	}

	public static inline function __advanceFrame():Void
	{
		#if ((cpp || neko) && hxtelemetry && !macro)
		hxTelemetry.advance_frame();
		#end
	}

	public static inline function __endTiming(name:String):Void
	{
		#if ((cpp || neko) && hxtelemetry && !macro)
		hxTelemetry.end_timing(name);
		#end
	}

	public static inline function __initialize():Void
	{
		#if ((cpp || neko) && hxtelemetry && !macro)
		var meta = Lib.application.meta;

		var config = new hxhxTelemetry.HxTelemetry.Config();
		config.allocations = (!meta.exists("hxtelemetry-allocations") || meta.get("hxtelemetry-allocations") == "true");
		config.host = (!meta.exists("hxtelemetry-host") ? "localhost" : meta.get("hxtelemetry-host"));
		config.app_name = meta.get("name");

		config.activity_descriptors = [
			{name: TelemetryCommandName.EVENT, description: "Event Handler", color: 0x2288cc},
			{name: TelemetryCommandName.RENDER, description: "Rendering", color: 0x66aa66}
		];
		telemetry = new HxTelemetry(config);
		#end
	}

	public static inline function __rewindStack(stack:String):Void
	{
		#if ((cpp || neko) && hxtelemetry && !macro)
		hxTelemetry.rewind_stack(stack);
		#end
	}

	public static inline function __startTiming(name:String):Void
	{
		#if ((cpp || neko) && hxtelemetry && !macro)
		hxTelemetry.start_timing(name);
		#end
	}

	public static inline function __unwindStack():String
	{
		#if ((cpp || neko) && hxtelemetry && !macro)
		return hxTelemetry.unwind_stack();
		#else
		return "";
		#end
	}

	// Get & Set Methods

	public static function get_connected():Bool
	{
		#if ((cpp || neko) && hxtelemetry && !macro)
		return true;
		#else
		return false;
		#end
	}
}

@:enum abstract TelemetryCommandName(String) from String to String
{
	public var EVENT = ".event";
	public var RENDER = ".render";
}