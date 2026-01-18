/*
 * Intel ACPI Component Architecture
 * USB Wake Disable Table
 * 
 * Prevents USB devices from waking the system
 * Fixes restart instead of wake issue on Broadwell
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "USBWAKE ", 0x00000001)
{
    External (_SB_.PCI0, UnknownObj)
    External (_SB_.PCI0.XHC_, UnknownObj)

    /*
     * Disable USB Power Management and Wake on USB
     * This prevents USB devices from causing improper wake events
     */
    Scope (_SB.PCI0.XHC_)
    {
        /*
         * _S3D: S3 Device State
         * Returns the highest device state that device supports in S3 sleep
         * D3 = Device turns off completely (no wake capability)
         */
        Method (_S3D, 0, NotSerialized)
        {
            Return (0x03)  // D3 state - no wake from S3
        }

        /*
         * _S4D: S4 Device State
         * For S4 (hibernation), same as S3
         */
        Method (_S4D, 0, NotSerialized)
        {
            Return (0x03)  // D3 state - no wake from S4
        }

        /*
         * _PRW: Power Resources for Wake
         * Return empty package to disable wake capabilities
         */
        Method (_PRW, 0, NotSerialized)
        {
            Return (Package (0x00) {})  // No wake resources
        }
    }

    /*
     * Also disable EHCI (Legacy USB) if present
     */
    Scope (_SB.PCI0.EHC1)
    {
        Method (_S3D, 0, NotSerialized)
        {
            Return (0x03)
        }

        Method (_S4D, 0, NotSerialized)
        {
            Return (0x03)
        }

        Method (_PRW, 0, NotSerialized)
        {
            Return (Package (0x00) {})
        }
    }

    Scope (_SB.PCI0.EHC2)
    {
        Method (_S3D, 0, NotSerialized)
        {
            Return (0x03)
        }

        Method (_S4D, 0, NotSerialized)
        {
            Return (0x03)
        }

        Method (_PRW, 0, NotSerialized)
        {
            Return (Package (0x00) {})
        }
    }
}
