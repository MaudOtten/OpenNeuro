### Week 1 (31-05-2021 / 06-06-2021)

**I came up with the idea of using open-source imaging data for a home analysis project. As I wanted to keep busy with neuroimaging, while being unemployed and not affiliated with any scientific institution, I wondered how far I could get with only open-source, free data and tools.**

- Monday: The idea started forming in my head when intermittently going through PyTorch tutorials, Kaggle datasets and eventually found OpenNeuro. Doing a project on something I had done before (creating a full neuroimaging processing pipeline) and had more interest in then a detached ML project seemed like a better use of my time. I downloaded 28AndMe dataset.
- Tuesday: I spent most of today looking through Medium and other platforms for similar projects. I found an encouraging article focussing on blogging for data scientists (core message: start doing it!). Also, I read an article pondering the point and use of open-source biological data. This could be useful in my own evaluation and motivation to the project.
- Wednesday: I downloaded Oracle and SPM12 (standalone version), with many hiccups in setting up the two softwares. I downloaded the main article on connectivity analysis from this dataset. Started on implementing the VDM calculation, getting familiar with Oracle scripting (some growing pains coming from the comfort of MATLAB).
- Thursday: Much time was spent on relearning some SPM scripting tricks in handling data types for proper loading of the batch. SPM standalone version is also very unstable, so much time was spent on restarting SPM and Oracle. Investing in scripting instead of using the GUI will pay off in the long run even more in this case.
- Friday: I set up a project repo to put my code online. This will make me more motivated to finish the, now public, product.
- Saturday: I finished setting up the repo. I aso wrote these updates for the week.


### Week 2 (07-06-2021 / 13-06-2021)

- Monday: I started off finishing the install of freesurfer and fmriprep-docker in order to eventually run fmriprep as a comparison to familiar spm tools. This took a considerable amount of time with wsl issues and trying to script part of the freesurfer setup in python. I ended up modifying my .bashrc to simplify things. I also spent some time deciphering the article and code of the author to understand the full pipeline (this takes quite a lot of time throughout the whole process so far).
- Tuesday: I found out that the subject-specific template used in the study is also available via another file-download platform.
- Wednesday: I downloaded the supplementary information from the article to get a better understanding of the preprocessing steps found in the paper and the code.
- Thursday: I focussed on the paper, supplementary material and github code to reconstruct all steps in the preprocessing pipeline, and to ensure that I understand each step fully.

*************************************************

_I contemplate the main goal of this project. Is it a more selfish, educational project for me to understand another study's pipeline and walk through it step by step tutorial-style? Or is it somehow supposed to have a verification element involving my own views on how to conduct neuroimaging research? This last option seems a bit arrogant considering my personal experience (limited) with doing fmri analysis, as well as the lack of expertise around me in contrast to published studies. Therefore, I need to rethink my attitude towards the code I find on github, as more a guideline then a comparison to my own ideas._

*************************************************

- Friday: Repo cleanup and README & UPDATE updated.
- Sunday: Presentation to Selina Veng (@sveng) on open-source (neuro)science and the project, and a brainstorm about the scope and form.


### Week 1 (14-06-2021 / 20-06-2021)

- Wednesday: Today I realized that the elusive 'hires' scan I was looking for in the original code referred to high-resolution structural. The more you know... Now the segmentation setup is a lot more straight forward to set up. I completed the unwarping and segmentation parts of the preprocessing pipeline, running it successfully on a subset of the data.
- Thursday: I had a lot of trouble with a Matlab package used in the original code to load Nifti images and headers, which wasn't compatible with Octave. I found an Octave-compatible package, but this didn't seem able to handle 4D images. A few packages further, I managed to load the images. However, some warnings did show, possibly indicating something went wrong in previous preprocessing steps..
- Friday: Total overhaul with software. Octave was acting out, making me un- and reinstall.