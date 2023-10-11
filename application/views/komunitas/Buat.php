<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4">Buat Komunitas</h2>
                        <p class="text-white mb-2">Buat komunitas kamu sendiri disini</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid mt--6">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header border-0">
                        <h4 class="mb-0">Masukan Data Komunitas</h4>
                    </div>
                    <div class="card-body">
                        <form method="post" action="<?php echo base_url() ?>komunitas/create" enctype="multipart/form-data">
                            <div class="p-lg-3">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="form-control-label" for="input-username">Nama Komunitas</label>
                                            <input type="text" name="nama" class="form-control" placeholder="Nama Komunitas" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="form-control-label" for="input-username">Jabatan</label>
                                            <input type="text" name="jabatan" class="form-control" placeholder="Jabatan kamu disini" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="form-control-label">Deskripsi Komunitas</label>
                                            <textarea rows="4" name="detail" class="form-control" required placeholder="Ceritakan tentang komunitas kamu disini"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="form-control-label" for="input-username">Logo Komunitas</label>
                                            <input type="file" name="logo" class="form-control" required>
                                            <small>Logo Harus berbentuk persegi</small>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 mt-3">
                                        <input type="submit" name="submit" value="Buat Komunitas" class="btn btn-danger">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>