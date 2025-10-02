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
                <connector>DP-1</connector>
                <vendor>MSI</vendor>
                <product>MSI MAG240CR</product>
                <serial>BA5H011402092</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>165.001</rate> <!-- Refresh rate -->
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
      </monitors>
    '';
  };
}
