<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4"><?php echo $data['nama'] ?></h2>
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
                        <div class="p-lg-3">
                            <div class="row">
                                <div class="col-md-2 col-12">
                                    <img class="rounded" src="<?php echo base_url() ?>/assets/images/komunitas/<?php echo $data['logo'] ?>" style="max-width: 100px; max-height: 100px;">
                                </div>
                                <div class="col-md-10 col-12">
                                    <h3><?php echo $data['nama'] ?></h3>
                                    <p><?php echo $data['detail'] ?></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header border-0">
                        <h4 class="mb-0">Anggota Komunitas</h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table align-items-center table-flush">
                            <thead class="thead-light">
                                <tr>
                                    <th class="text-center">Nama</th>
                                    <th class="text-center">Tanggal Gabung</th>
                                    <th class="text-center">Jabatan</th>
                                    <th class="text-center">Level</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody class="list">
                                <?php if ($anggota) { ?>
                                    <?php foreach ($anggota as $dt) { ?>
                                        <tr>
                                            <td class="text-center">
                                                <strong><?php echo $dt->nama_user ?></strong>
                                            </td>
                                            <td class="text-center"><?php echo $dt->created_at ?></td>
                                            <td class="text-center"><?php echo $dt->jabatan ?></td>
                                            <?php if ($dt->is_admin) { ?>
                                                <td class="text-center">Administrator
                                                    <?php if ($cek_anggota): ?>
                                                        <a href="<?php echo base_url() ?>komunitas/setanggota/<?php echo $dt->id ?>/<?php echo $dt->token_komunitas ?>/<?php echo $dt->id_user ?>" class="badge badge-danger">Ubah</a>
                                                        
                                                    <?php endif ?>
                                                </td>
                                            <?php } else { ?>
                                                <td class="text-center">Anggota
                                                    <?php if ($cek_anggota): ?>
                                                        <a href="<?php echo base_url() ?>komunitas/setadmin/<?php echo $dt->id ?>/<?php echo $dt->token_komunitas ?>" class="badge badge-danger">Ubah</a>
                                                        
                                                    <?php endif ?>
                                                </td>
                                            <?php } ?>
                                            <td class="text-center">
                                                <a href="<?php echo base_url() ?>komunitas/detailanggota/<?php echo $dt->id_user ?>" class="badge badge-primary">
                                                    <i class="ni ni-button-play"></i>
                                                </a>
                                                <?php if ($cek_anggota) : ?>
                                                    <a href="<?php echo base_url() ?>komunitas/deleteanggota/<?php echo $dt->id ?>/<?php echo $dt->token_komunitas ?>" class="badge badge-danger">
                                                        <i class="ni ni-scissors"></i>
                                                    </a>
                                                <?php endif ?>
                                            </td>
                                        </tr>
                                    <?php } ?>
                                <?php } else { ?>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer py-4">
                        <?php if ($cek_anggota): ?>
                            <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#exampleModal">
                                Tambah Anggota +
                            </button>
                        <?php endif ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <form action="<?php echo base_url() ?>komunitas/addanggota" method="post">
                    <input type="hidden" name="id_komunitas" value="<?php echo $data['id'] ?>">
                    <input type="hidden" name="token_komunitas" value="<?php echo $data['token'] ?>">
                    <div class="form-group">
                        <label class="form-control-label" for="input-username">Email User</label>
                        <input type="email" name="email" class="form-control" placeholder="Masukan email user" required>
                    </div>
                    <div class="form-group">
                        <label class="form-control-label" for="input-username">Jabatan</label>
                        <input type="text" name="jabatan" class="form-control" placeholder="Jabatan" required>
                    </div>
                    <div class="custom-control custom-radio mb-2">
                        <input type="radio" id="customRadio1" name="is_admin" value="1" class="custom-control-input" required>
                        <label class="custom-control-label" for="customRadio1">Administrator</label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input type="radio" id="customRadio2" name="is_admin" value="0" class="custom-control-input" required>
                        <label class="custom-control-label" for="customRadio2">Anggota</label>
                    </div>
                    <input type="submit" name="submit" value="Tambahkan Anggota" class="btn btn-danger mt-5 btn-block">
                </form>
            </div>
        </div>
    </div>
</div>