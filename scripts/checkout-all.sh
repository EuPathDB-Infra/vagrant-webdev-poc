#/usr/bin/env sh

if [ -z "$1" ]; then
  BRANCH="trunk"
else
  BRANCH="branches/$1"
fi

svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/ApiCommonDatasets/$BRANCH ApiCommonDatasets
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/ApiCommonModel/$BRANCH ApiCommonModel
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/ApiCommonPresenters/$BRANCH ApiCommonPresenters
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/ApiCommonWebService/$BRANCH ApiCommonWebService
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/ApiCommonWebsite/$BRANCH ApiCommonWebsite
svn co https://cbilsvn.pmacs.upenn.edu/svn/gus/CBIL/$BRANCH CBIL
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/ClinEpiDatasets/$BRANCH ClinEpiDatasets
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/ClinEpiModel/$BRANCH ClinEpiModel
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/ClinEpiPresenters/$BRANCH ClinEpiPresenters
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/ClinEpiWebsite/$BRANCH ClinEpiWebsite
svn co https://cbilsvn.pmacs.upenn.edu/svn/gus/DJob/$BRANCH DJob
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/EbrcModelCommon/$BRANCH EbrcModelCommon
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/EbrcWebSvcCommon/$BRANCH EbrcWebSvcCommon
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/EbrcWebsiteCommon/$BRANCH EbrcWebsiteCommon
svn co https://cbilsvn.pmacs.upenn.edu/svn/gus/FgpUtil/$BRANCH FgpUtil
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/GBrowse/$BRANCH GBrowse
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/MicrobiomeDatasets/$BRANCH MicrobiomeDatasets
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/MicrobiomeModel/$BRANCH MicrobiomeModel
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/MicrobiomePresenters/$BRANCH MicrobiomePresenters
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/MicrobiomeWebsite/$BRANCH MicrobiomeWebsite
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/OrthoMCLModel/$BRANCH OrthoMCLModel
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/OrthoMCLWebService/$BRANCH OrthoMCLWebService
svn co https://cbilsvn.pmacs.upenn.edu/svn/apidb/OrthoMCLWebsite/$BRANCH OrthoMCLWebsite
svn co https://cbilsvn.pmacs.upenn.edu/svn/gus/ReFlow/$BRANCH ReFlow
svn co https://cbilsvn.pmacs.upenn.edu/svn/gus/TuningManager/$BRANCH TuningManager
svn co https://cbilsvn.pmacs.upenn.edu/svn/gus/WDK/$BRANCH WDK
svn co https://cbilsvn.pmacs.upenn.edu/svn/gus/WSF/$BRANCH WSF
svn co https://cbilsvn.pmacs.upenn.edu/svn/gus/install/$BRANCH install
