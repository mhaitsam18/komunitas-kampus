<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4">Hi Kak <?php echo $this->session->userdata('name'); ?> </h2>
                        <p class="text-white mb-2">Selamat datang di laman forum komunitas</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid mt--6">
        <div class="row">
            <div class="col">
                <?php if ($thread): ?>
                    <div class="card">
                        <div class="card-body">
                        <a href="<?php echo base_url() ?>/forum/create"><strong><i class="fas fa-plus"></i> Add Thread</strong></a>
                            <?php foreach ($thread as $t) { ?>
                                <div class="p-lg-4">
                                    <h4 class="mb-0"><?php echo $t->judul ?></h4>
                                    <p><small>Oleh : <?php echo $t->nama_thread ?></small></p>
                                    <p><small>Komunitas : <?php echo $t->nama ?></small></p>
                                    <p><small><?php echo date("l, d M Y H:s:i", strtotime($t->waktu_upload)) ?></small></p>
                                    <p class="pt-3"><?php echo $t->isi ?></p>
                                    <a href="<?php echo base_url() ?>forum/detail/<?php echo $t->id_thread ?>"><strong>detail...</strong></a>
                                </div>
                            <?php } ?>
                        </div>
                    </div>
                <?php else: ?>
                    <div class="card text-center">
                        <div class="pt-7 pb-6">
                            <p>Thread not found. <a href="<?php echo base_url() ?>/forum/create"><strong>Create Here</strong></a></p>
                        </div>
                    </div>
                <?php endif ?>
            </div>
        </div>
    </div>
</div>