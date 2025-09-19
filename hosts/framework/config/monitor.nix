{ hostVars, ... }:

{
  hm.xdg.configFile."monitors.xml" = {
    force = true;

    text = # xml
    ''
      <monitors version="2">
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>${builtins.toString hostVars.scalingFactor}</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>eDP-1</connector>
                <vendor>BOE</vendor>
                <product>0x0bca</product>
                <serial>0x00000000</serial>
              </monitorspec>
              <mode>
                <width>2256</width>
                <height>1504</height>
                <rate>59.999</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
      </monitors>
    '';
  };
}
