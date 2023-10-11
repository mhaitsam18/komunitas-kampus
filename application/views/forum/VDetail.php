<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4">Hi Kak <?php echo $this->session->userdata('name'); ?> </h2>
                        <p class="text-white mb-2">Selamat datang di laman detail thread</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid mt--6">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-body">
                        <div class="p-lg-4">
                            <h4 class="mb-0"><?php echo $thread->judul ?></h4>
                            <p><small>Oleh : <?php echo $thread->nama_user ?></small></p>
                            <p><small><?php echo date("l, d M Y H:s:i", strtotime($thread->created_at)) ?></small></p>
                            <p class="pt-3"><?php echo $thread->isi ?></p>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="p-lg-4">
                            <form method="post" action="<?php echo base_url() ?>forum/komentar/<?php echo $thread->id ?>">
                                <div class="form-group">
                                    <label class="form-control-label">Tambahkan Komentar</label>
                                    <textarea rows="4" name="komentar" class="form-control" required></textarea>
                                </div>
                                <input type="submit" name="submit" value="Submit" class="btn btn-danger">
                            </form>
                        </div>
                    </div>
                </div>
                <?php if ($komentar) { ?>
                    <?php foreach ($komentar as $k) { ?>
                        <div class="card">
                            <div class="card-body">
                                <div class="p-lg-4">
                                    <p class="pb-0 mb-0"><small><?php echo $k->nama_user ?></small></p>
                                    <p><small><?php echo date("l, d M Y H:s:i", strtotime($k->created_at)) ?></small></p>
                                    <p class="pt-3"><?php echo $k->komentar ?></p>
                                </div>
                            </div>
                        </div>
                    <?php } ?>
                <?php } else { ?>
                    <div class="card text-center">
                        <div class="pt-4 pb-3">
                            <p>Belum ada komentar sejauh ini</p>
                        </div>
                    </div>
                <?php } ?>
            </div>
        </div>
    </div>
</div>