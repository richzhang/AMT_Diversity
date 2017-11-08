function [] = mk_expt(expt_name, simultaneous, time_image_display, time_image_gap, time_button_delay, subset)
%% expt parameters
opt = getOpts(expt_name, simultaneous, time_image_display, time_image_gap, time_button_delay, subset);

%% check parameters
checkOpts(opt);

%% make dir for expt, overwriting if it already exists
if (exist(opt.expt_name,'dir'))
    system(sprintf('rm -r ./%s',opt.expt_name));
end
mkdir(opt.expt_name);
fprintf('Experiment name: %s\n',opt.expt_name)

%%
rng('shuffle');

%%
csv_fname = fullfile(opt.expt_name,sprintf('%s.csv',opt.subset));
opt.Nalgs = numel(opt.algs_paths);

images_p0 = {};
images_p1 = {};
images_same = {};

% opt.algs_paths = {'alg0','alg1','alg2'};
% opt.Nimgs = 27500;                        % number of images available to test
% opt.Nzs = 1000;                        % number of samples per image
% opt.Npairs = 810;                        % number of paired comparisons per HIT
% opt.Npractice = 5;                     % number of practice trials per HIT (number of non-practice trials is opt.Npairs-opt.Npractice)
% opt.Nhits = 5;                 % number of HITs

% headers on csv
for i=1:opt.Npairs
    images_p0{1,i} = sprintf('images_p0_%i',i);
    images_p1{1,i} = sprintf('images_p1_%i',i);
    images_same{1,i} = sprintf('images_same_%i',i);
end

% for which_alg_curr=1:length(opt.which_algs_paths) % each trial tests just one alg
for j=1:opt.Nhits % number of hits
    % vigilance indices
    Nvigil_total = 0;
    if(opt.use_vigilance)
        vigilance_flag = false(1,opt.Npairs);
        vigilance_inds = zeros(1,opt.Npairs);
        Nvigil_practice = ceil(opt.vigilance_freq*opt.Npractice);
        Nvigil_real = ceil(opt.vigilance_freq*(opt.Npairs-opt.Npractice));
        Nvigil_total = Nvigil_practice + Nvigil_real;

        which_imgs_vig = randperm(opt.Nvigilance)-1;
        which_imgs_vig = which_imgs_vig(1:Nvigil_total); % test images

        vigil_inds_practice = randperm(opt.Npractice);
        vigil_inds_practice = vigil_inds_practice(1:Nvigil_practice);
        vigilance_flag(vigil_inds_practice) = true;
        vigilance_inds(vigil_inds_practice) = which_imgs_vig(1:Nvigil_practice); % put test image indices into vigilance

        vigil_inds_real = randperm(opt.Npairs-opt.Npractice);
        vigil_inds_real = vigil_inds_real(1:Nvigil_real)+opt.Npractice;
        vigilance_flag(vigil_inds_real) = true;
        vigilance_inds(vigil_inds_real) = which_imgs_vig(Nvigil_practice+1:end); % put test image indices into vigilance
    end
    
    assert(sum(vigilance_flag(1:opt.Npractice)>0)==Nvigil_practice)

    % actual test images
%     which_imgs_alg = randperm(opt.Nimgs)-1;
%     which_imgs_alg = which_imgs_alg(1:opt.Npairs); % choose random set of images to test on, from test set
%     which_imgs_alg = (j-1)*(opt.Npairs-Nvigil_total) + (1:(opt.Npairs-Nvigil_total));
%     which_imgs_alg = [which_imgs_alg max(which_imgs_alg(:))+zeros(1,Nvigil_total)];
    which_imgs_alg = (j-1)*(opt.Npairs-Nvigil_total) + (0:opt.Npairs-1);
    for vigilance_ind = find(vigilance_flag)
        which_imgs_alg(vigilance_ind:end) = which_imgs_alg(vigilance_ind:end)-1;
        which_imgs_alg(vigilance_ind) = 0;
    end
    assert(max(which_imgs_alg) < opt.Nimgs)

    for i=1:opt.Npairs
%             if (opt.use_vigilance && (rand(1)<=opt.vigilance_freq)) % opt.vigilance_freq proportion of trials are vigilance checks
%                 alg_im_name = sprintf('%s/%06d',opt.vigilance_path,which_imgs_alg(i));
%             else
%                 alg_im_name = sprintf('%s/%06d',opt.which_algs_paths{which_alg_curr},which_imgs_alg(i));
%             end

        if(vigilance_inds(i))
            if(rand > .5) % show the same image half of the time
                folder0 = 'ref';
                folder1 = 'ref';
                images_same{j+1,i} = '1';
            else
                folder0 = 'ref';
                folder1 = 'p0';
                images_same{j+1,i} = '0';
            end
            images_p0{j+1,i} = sprintf('%s/%s/%s/%06d',opt.subset,opt.vigilance_path,folder0,vigilance_inds(i));
            images_p1{j+1,i} = sprintf('%s/%s/%s/%06d',opt.subset,opt.vigilance_path,folder1,vigilance_inds(i));
        else
            if(rand > .5) % flip order half the time
                folder0 = 'p0';
                folder1 = 'ref';
                images_same{j+1,i} = '0';
            else
                folder0 = 'ref';
                folder1 = 'p0';
                images_same{j+1,i} = '0';
            end
            value = rand;
            images_p0{j+1,i} = sprintf('%s/%s/%06d',opt.subset,folder0,which_imgs_alg(i));
            images_p1{j+1,i} = sprintf('%s/%s/%06d',opt.subset,folder1,which_imgs_alg(i));
        end
    end
end



% % for which_alg_curr=1:length(opt.which_algs_paths) % each trial tests just one alg
% for j=1:opt.Nhits % number of hits
% 
% %         % vigilance indices
% %         vigilance_inds = zeros(1,opt.Npairs);
% %         Nvigil_practice = ceil(opt.vigilance_freq*opt.Npractice);
% %         Nvigil_real = ceil(opt.vigilance_freq*(opt.Npairs-opt.Npractice));
% %         Nvigil_total = Nvigil_practice + Nvigil_real;
% %         if(opt.use_vigilance)
% %             which_imgs_vig = randperm(opt.Nvigilance)-1;
% %             which_imgs_vig = which_imgs_vig(1:Nvigil_total); % test images
% % 
% %             vigil_inds_practice = randperm(opt.Npractice);
% %             vigil_inds_practice = vigil_inds_practice(1:Nvigil_practice);
% %             vigilance_inds(vigil_inds_practice) = which_imgs_vig(1:Nvigil_practice); % put test image indices into vigilance
% %             
% %             vigil_inds_real = randperm(opt.Npairs-opt.Npractice);
% %             vigil_inds_real = vigil_inds_real(1:Nvigil_real)+opt.Npractice;
% %             vigilance_inds(vigil_inds_real) = which_imgs_vig(Nvigil_practice+1:end); % put test image indices into vigilance
% %         end
% 
%     % actual test images
%     which_zs_0 = randi(opt.Nzs,1,opt.Npairs)-1; % generate from [0,Nzs)
%     which_zs_1 = randi(opt.Nzs-1,1,opt.Npairs)-1; % generate from [0, Nzs-1)
%     which_zs_1(which_zs_1==which_zs_0) = which_zs_1(which_zs_1==which_zs_0)+1; % remove clashes by adding 1 if they are equal
%     which_imgs = randi(opt.Nimgs,1,opt.Npairs)-1;
%     which_algs = randi(opt.Nalgs,1,opt.Npairs);
% 
%     for i=1:opt.Npairs
% %             if (opt.use_vigilance && (rand(1)<=opt.vigilance_freq)) % opt.vigilance_freq proportion of trials are vigilance checks
% %                 alg_im_name = sprintf('%s/%06d',opt.vigilance_path,which_imgs_alg(i));
% %             else
% %                 alg_im_name = sprintf('%s/%06d',opt.which_algs_paths{which_alg_curr},which_imgs_alg(i));
% %             end
% 
%         which_imgs_alg = (j-1)*(opt.Npairs-Nvigil_total) + (0:opt.Npairs-1);
%         for vigilance_ind = find(vigilance_inds)
%             which_imgs_alg(vigilance_ind:end) = which_imgs_alg(vigilance_ind:end)-1;
%             which_imgs_alg(vigilance_ind) = 0;
%         end
%         assert(max(which_imgs_alg) < opt.Nimgs)
% 
% %         if(vigilance_inds(i))
% %             images_p0{j+1,i} = sprintf('%s/%s/%06d',opt.vigilance_path,'p0',vigilance_inds(i));
% %             images_p1{j+1,i} = sprintf('%s/%s/%06d',opt.vigilance_path,'p1',vigilance_inds(i));
% %         else
% %         images_p0{j+1,i} = sprintf('%s/img%06d_samp%06d',opt.algs_paths{which_algs(i)},which_imgs(i),which_zs_0(i));
% %         images_p1{j+1,i} = sprintf('%s/img%06d_samp%06d',opt.algs_paths{which_algs(i)},which_imgs(i),which_zs_1(i));
%         images_p0{j+1,i} = sprintf('%s/ref/%i.png',opt.algs_paths{which_algs(i)},which_imgs(i),which_zs_0(i));
%         images_p1{j+1,i} = sprintf('%s/p0/%i.png',opt.algs_paths{which_algs(i)},which_imgs(i),which_zs_1(i));
% %         end
% 
%         % 	            if (randi(2)==1) % randomize which side of UI gt is on
%         % 	                gt_side{(which_alg_curr-1)*opt.Nhits_per_alg+j+1,i} = 'left';
%         %  	                images_p0{(which_alg_curr-1)*opt.Nhits_per_alg+j+1,i} = sprintf('%s/%d',opt.gt_path,which_imgs_gt(i));
%         % 	            else
%         % 	                gt_side{(which_alg_curr-1)*opt.Nhits_per_alg+j+1,i} = 'right';
%         % 	                images_p0{(which_alg_curr-1)*opt.Nhits_per_alg+j+1,i} = alg_im_name;
%         %  	                images_p1{(which_alg_curr-1)*opt.Nhits_per_alg+j+1,i} = sprintf('%s/%d',opt.gt_path,which_imgs_gt(i));
%         % 	                images_p1{(which_alg_curr-1)*opt.Nhits_per_alg+j+1,i} = sprintf('%s/%06d',opt.gt_path,which_imgs_gt(i));
%         % 	            end
%     end
% end

A = cat(2,images_p0,images_p1,images_same);

% rp = randperm(size(A,1)-1)+1; A = A([1,rp],:); % randomize HIT order (I think MTurk does this but let's do it here as well for safety)

fid = fopen(csv_fname,'w');
for i=1:size(A,1)
    for j=1:size(A,2)-1
        fprintf(fid,[A{i,j},',']);
    end
    fprintf(fid,A{i,end});
    fprintf(fid,'\n');
end
fclose(fid);

%% html code generator
html = fileread('index_template_mod.html');

html = strrep(html, '{{UT_ID}}', opt.ut_id);
html = strrep(html, '{{BASE_URL}}', opt.base_url);

html = strrep(html, '{{INSTRUCTIONS}}', fileread(opt.instructions_file));
html = strrep(html, '{{SHORT_INSTRUCTIONS}}', fileread(opt.short_instructions_file));
html = strrep(html, '{{CONSENT}}', fileread(opt.consent_file));

html = strrep(html, '{{IM_DIV_HEIGHT}}', num2str(opt.im_height+2));
html = strrep(html, '{{IM_DIV_WIDTH}}', num2str(opt.im_width+2));
html = strrep(html, '{{IM_HEIGHT}}', num2str(opt.im_height));
html = strrep(html, '{{IM_WIDTH}}', num2str(opt.im_width));

html = strrep(html, '{{N_PRACTICE}}', num2str(opt.Npractice));
html = strrep(html, '{{TOTAL_NUM_IMS}}', num2str(opt.Npairs));

html = strrep(html, '{{DISPLAY_TIME}}', num2str(opt.time_image_display));
html = strrep(html, '{{GAP_TIME}}', num2str(opt.time_image_gap));
html = strrep(html, '{{BUTTON_DELAY_TIME}}', num2str(opt.time_button_delay));
html = strrep(html, '{{SIMUL}}', num2str(opt.simultaneous));

s = [];
for i=1:opt.Npairs
    s = cat(2,s,sprintf('sequence_helper("${images_p0_%i}","${images_p1_%i}",);\n',i,i));
end
html = strrep(html, '{{SEQUENCE}}', s);

s = [];
for i=1:opt.Npairs
    s = cat(2,s,sprintf('<input type="hidden" name="selection%i" id="selection%i" value="unset">\n',i,i));
end
html = strrep(html, '{{SELECTION}}', s);

fprintf('Html file made: %s\n',fullfile(opt.expt_name,'index.html'))
fid = fopen(fullfile(opt.expt_name,'index.html'),'w');
fprintf(fid,'%s',html);
fclose(fid);


end

