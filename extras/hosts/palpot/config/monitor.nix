{ config, ... }:

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
            <scale>${builtins.toString config.hostVars.scalingFactor}</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>eDP-1</connector>
                <vendor>LGD</vendor>
                <product>0x07a6</product>
                <serial>0x00000000</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1200</height>
                <rate>60.001</rate>
              </mode>
            </monitor>
          </logicalmonitor>
       </configuration>
    </monitors>
    '';
  };
}
