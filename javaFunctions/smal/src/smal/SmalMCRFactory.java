/*
 * MATLAB Compiler: 4.17 (R2012a)
 * Date: Thu Apr 24 13:05:31 2014
 * Arguments: "-B" "macro_default" "-W" "java:smal,smalDetector" "-T" "link:lib" "-d" 
 * "D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\smal\\src" "-w" 
 * "enable:specified_file_mismatch" "-w" "enable:repeated_file" "-w" 
 * "enable:switch_ignored" "-w" "enable:missing_lib_sentinel" "-w" "enable:demo_license" 
 * "-v" 
 * "class{smalDetector:D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\classifier.m,D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\inremental.m,D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\metrics.m,D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\smal.m,D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\updateTraining.m}" 
 */

package smal;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class SmalMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "smal_E56028F86769417F2D9EB5E099382541";
    
    /** Component name */
    private static final String sComponentName = "smal";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(SmalMCRFactory.class)
        );
    
    
    private SmalMCRFactory()
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
            SmalMCRFactory.class, 
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
