/*
 * MATLAB Compiler: 4.17 (R2012a)
 * Date: Thu Jun 12 11:56:50 2014
 * Arguments: "-B" "macro_default" "-W" "java:siftExtraction,sift" "-T" "link:lib" "-d" 
 * "D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\siftExtraction\\src" 
 * "-w" "enable:specified_file_mismatch" "-w" "enable:repeated_file" "-w" 
 * "enable:switch_ignored" "-w" "enable:missing_lib_sentinel" "-w" "enable:demo_license" 
 * "-v" 
 * "class{sift:D:\\lena\\Codes\\MyCodes\\LaplacianEigenmaps_Code\\matlab\\SIFTFeatureExtraction\\featureExtractionFunc.m}" 
 */

package siftExtraction;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class SiftExtractionMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "siftExtracti_C0CA931E03DC0DA747E5EEF2A3042120";
    
    /** Component name */
    private static final String sComponentName = "siftExtraction";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(SiftExtractionMCRFactory.class)
        );
    
    
    private SiftExtractionMCRFactory()
    {
        // Never called.
    }
    
    public static MWMCR newInstance(MWComponentOptions componentOptions) throws MWException
    {
        if (null == componentOptions.getCtfSource()) {
            componentOptions = new MWComponentOptions(componentOptions);
            componentOptions.setCtfSource(sDefaultComponentOptions.getCtfSource());
        }
        return MWMCR.newInstance(
            componentOptions, 
            SiftExtractionMCRFactory.class, 
            sComponentName, 
            sComponentId,
            new int[]{7,17,0}
        );
    }
    
    public static MWMCR newInstance() throws MWException
    {
        return newInstance(sDefaultComponentOptions);
    }
}
