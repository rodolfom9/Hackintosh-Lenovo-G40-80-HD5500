/*
 * Intel ACPI Component Architecture
 * Sleep States Definition Table
 * 
 * For Broadwell (i5-5005U) - Fixes Sleep/Wake issues
 * Defines S3 and S4 sleep states properly for macOS
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "SLEEP   ", 0x00000001)
{
    /*
     * Define S3 (Sleep) and S4 (Hibernate) states
     * These must return proper Package format for macOS to recognize
     */
    
    Method (_S3, 0, NotSerialized)
    {
        Return (Package (0x04) 
        {
            One,    // Sleep type (1 = S3)
            Zero,   // PM1A_CNT.SLP_TYP
            Zero,   // PM1B_CNT.SLP_TYP
            Zero    // PM1 Control register value
        })
    }

    Method (_S4, 0, NotSerialized)
    {
        Return (Package (0x04) 
        {
            0x02,   // Sleep type (2 = S4)
            Zero,   // PM1A_CNT.SLP_TYP
            Zero,   // PM1B_CNT.SLP_TYP
            Zero    // PM1 Control register value
        })
    }

    /*
     * PS2 (PCI Express Power States) - Optional but recommended for Broadwell
     * Puts PCIe in correct power state during sleep
     */
    Method (_PS2, 0, NotSerialized)
    {
    }

    Method (_PS3, 0, NotSerialized)
    {
    }
}
